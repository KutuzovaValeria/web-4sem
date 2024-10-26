from flask import Blueprint, render_template, request, flash, redirect, url_for, abort, send_from_directory
from app import db
from models import *
from flask_login import current_user, login_required, current_user
from sqlalchemy import func
from tools import ImageSaver
from auth import permission_check
import markdown
import bleach

bp = Blueprint('books', __name__, url_prefix='/books')

BOOK_PARAMS = [
    'name', 'author', 'year', 'description', 'publisher', 'volume', 'genres'
]


def params():
    book_params = {p: request.form.get(p) for p in BOOK_PARAMS}
    genre_ids = request.form.getlist('genres')
    genres = Genre.query.filter(Genre.id.in_(genre_ids)).all()
    book_params['genres'] = genres
    return book_params


@bp.route('/add_book', methods=['GET', 'POST'])
@login_required
@permission_check("create")
def add_book():
    genres = Genre.query.all()
    book = Book()
    if request.method == 'POST':
        return redirect(url_for('books.create_book'))
    return render_template('add_book.html', genres=genres, book=book)


@bp.route('/create_book', methods=['POST'])
@login_required
@permission_check("create")
def create_book():
    try:
        f = request.files.get('background_img')  # обработка изображения
        if f and f.filename:
            img = ImageSaver(f).save()
            image_id = img.id

        if not request.form.get('name') or not request.form.get('author') or not request.form.get('genres') or \
           not request.form.get('year') or not request.form.get('description') or not request.form.get('publisher'):
            flash('Заполните все обязательные поля.', 'danger')
            return redirect(url_for('index'))

        genre_name = request.form.get('genres')

        if genre_name:
            genre = Genre.query.filter_by(name=genre_name).first()
            if genre:
                book_genre = BookGenre(book=book, genre=genre) # создание связи между жанром и книгой
                db.session.add(book_genre)

        book = Book(**params(), id_image=image_id)

        description = bleach.clean(request.form.get('description')) #удаляет потенциально вредоносные HTML-теги и JavaScript
        book.description = description

        bleach.clean(book.description)

        db.session.add(book)
        db.session.commit()

        flash(f'Книга {book.name} была успешно добавлена!', 'success')
        return redirect(url_for('index'))

    except:
        db.session.rollback()
        flash('При сохранении данных возникла ошибка. Проверьте корректность введенных данных.', 'danger')
        return redirect(url_for('index'))


@bp.route('<int:book_id>/edit', methods=['GET', 'POST'])
@login_required
@permission_check("edit_book")
def edit_book(book_id):

    book = Book.query.get(book_id)
    genres = Genre.query.all()

    if not book:
        flash('Книга не найдена', 'danger')
        return redirect(url_for('books'))

    try:
        if request.method == 'POST':

            if not request.form.get('name') or not request.form.get('author') or not request.form.get('genres') or \
                    not request.form.get('year') or not request.form.get('description') or not request.form.get('publisher'):
                flash('Заполните все обязательные поля.', 'danger')
                return redirect(url_for('add_book'))

            name = request.form.get('name')
            author = request.form.get('author')
            year = request.form.get('year')
            description = request.form.get('description')
            selected_genre_ids = request.form.getlist('genres')
            publisher = request.form.get('publisher')
            volume = request.form.get('volume')

            description = bleach.clean(request.form.get('description'))
            book.description = description

            book.name = name
            book.author = author
            book.year = year
            book.description = description
            book.genres = Genre.query.filter(
                Genre.id.in_(selected_genre_ids)).all()
            book.publisher = publisher
            book.volume = volume

            bleach.clean(book.description)

            db.session.commit()
            flash('Книга успешно обновлена', 'success')
            return redirect(url_for('index'))
    except:
        db.session.rollback()
        flash('Ошибка загрузки данных', 'danger')
        return redirect(url_for('index'))

    return render_template('edit_book.html', book=book, genres=genres)


def calc_book_rating(book_id):

    book = Book.query.get(book_id)

    rating_sum = book.rating_sum

    rating_num = book.rating_num

    if rating_num == 0:
        return 0

    return rating_sum / rating_num


@bp.route('/<int:book_id>')
@login_required
def show(book_id):

    book = Book.query.get(book_id)

    reviews_all = Review.query.filter_by(
        book_id=book_id).order_by(Review.created_at.desc()).all()

    book.description = markdown.markdown(book.description)

    book_rating = calc_book_rating(book_id)

    users = User.query.all()

    images = Image.query.all()

    flag = False
    for review in reviews_all:

        review.text = markdown.markdown(review.text)
        try:
            if review.user_id == current_user.id:
                flag = True
        except:
            pass

    reviews_lim5 = Review.query.filter_by(
        book_id=book_id).order_by(Review.created_at.desc()).all()

    return render_template('show.html', book=book, reviews_all=reviews_all, reviews_lim5=reviews_lim5, users=users, images=images, flag=flag, book_id=book_id, book_rating=book_rating)


@bp.route('<int:book_id>/delete', methods=['POST'])
@login_required
@permission_check("delete")
def delete_book(book_id):
    book = Book.query.get(book_id)
    image = Image.query.filter_by(id=book.id_image).first()
    if not book:
        flash('Книга не найдена', 'danger')
        return redirect(url_for('books'))

    try:
        #os.remove(f'media/images/{image.file_name}')
        extension = image.file_name.split('.')[-1]
        os.remove(f'media/images/{image.id}')
        db.session.delete(book)
        db.session.delete(image)
        db.session.commit()
        flash('Книга успешно удалена', 'success')
    except:
        db.session.rollback()
        flash('При удалении книги возникла ошибка', 'danger')

    return redirect(url_for('index'))


@bp.route('/<int:book_id>/reviews', methods=['GET'])
def reviews(book_id):
    book = Book.query.get(book_id)

    page = request.args.get('page', 1, type=int)
    five_per_page = 5

    sort_by = request.args.get('sort_by', 'new', type=str)
    if sort_by == 'positive':
        order_by = Review.rating.desc()
    elif sort_by == 'negative':
        order_by = Review.rating.asc()
    else:
        order_by = Review.created_at.desc()

    reviews_all = Review.query.filter_by(book_id=book_id)\
        .join(User)\
        .add_columns(User.login)\
        .add_columns(User.last_name)\
        .add_columns(User.first_name)\
        .order_by(order_by)\
        .paginate(page=page, per_page=five_per_page, error_out=False)

    if current_user.is_authenticated:
        flag = False
        existing_review = Review.query.filter_by(
            book_id=book_id, user_id=current_user.id).first()
        if existing_review:
            flag = True
    else:
        flag = None

    return render_template('reviews.html', book=book, reviews_all=reviews_all, flag=flag,  sort_by=sort_by, per_page=five_per_page, page=page)


@bp.route('/<int:book_id>/add_review', methods=['POST'])
@login_required
def add_review(book_id):
    try:

        if not current_user.is_authenticated:
            flash('Для оставления отзыва необходимо войти в свой аккаунт.', 'warning')
            return redirect(url_for('auth.login'))

        if not request.form.get('text'):
            flash('Напишите отзыв, почему вы не написали ', 'danger')
            return redirect(url_for('books.reviews', book_id=book_id))

        rating = int(request.form['rating'])
        text = request.form['text']
        sanitized_text = bleach.clean(text)

        if rating < 0 or rating > 5:
            flash('Недопустимая оценка', 'danger')
            return redirect(url_for('books.review', book_id=book_id))

        existing_review = Review.query.filter_by(
            book_id=book_id, user_id=current_user.id).first()
        if existing_review:
            flash('Вы уже оставили отзыв для этого курса.', 'danger')
            return redirect(url_for('books.show', book_id=book_id))

        review = Review(rating=rating, text=sanitized_text, created_at=func.now(
        ), book_id=book_id, user_id=current_user.id)
        db.session.add(review)
        db.session.commit()

        book = Book.query.get(book_id)
        book.rating_num += 1
        book.rating_sum += rating
        db.session.add(book)
        db.session.commit()

        flash('Отзыв успешно добавлен.', 'success')

        return redirect(url_for('books.show', book_id=book_id, rating=rating))
    except:
        db.session.rollback()
        flash('При сохранении данных возникла ошибка. Проверьте корректность введенных данных.', 'danger')
        return redirect(url_for('books.show', book_id=book_id))


@bp.route('/<int:book_id>/reviews', methods=['GET'])
def view_reviews(book_id):
    book = Book.query.get(book_id)

    reviews = Review.query.filter_by(
        book_id=book_id).order_by(Review.created_at.desc())

    users = User.query.all()

    return render_template('reviews.html', book=book, reviews=reviews, users=users)
