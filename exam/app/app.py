from flask import Flask, Blueprint, render_template, abort, send_from_directory, request
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_login import LoginManager


app = Flask(__name__)
application = app

app.config.from_pyfile('config.py')

db = SQLAlchemy(app)
migrate = Migrate(app, db)
login_manager = LoginManager(app)

from auth import bp as auth_bp, init_login_manager, permission_check, login_required
from books import bp as book_bp

app.register_blueprint(auth_bp)
app.register_blueprint(book_bp)

init_login_manager(app)

from models import Book, Image, Genre, Review
from tools import BookFilter
PER_PAGE = 5 #кол-во элементов на странице

def search_params():
    return {
        'name': request.args.get('name'),
        'genre_ids': request.args.getlist('genre_ids'),
    }

@app.route('/')
def index():
    page = request.args.get('page', 1, type=int)
    
    # Извлечение параметров поиска
    def search_params():
        return {
            'name': request.args.get('name'),
            'genre_ids': request.args.getlist('genre_ids'),
            'year': request.args.get('year', type=int),
            'volume_from': request.args.get('volume_from', type=int),
            'volume_to': request.args.get('volume_to', type=int),
            'author': request.args.get('author')
        }

    # Применение фильтрации
    books_query = BookFilter(**search_params()).perform()
    
    # Пагинация с учетом фильтрации
    pagination = books_query.paginate(page=page, per_page=PER_PAGE, error_out=False)
    books = pagination.items
    
    
    years = db.session.query(Book.year.distinct()).order_by(Book.year).all() #извлекаем годы из бд, сортируем по возрастанию
    years = [str(year[0]) for year in years] #список лет в формате строк
    
    # Подсчет отзывов и рейтингов для каждой книги
    reviews = []
    for book in books:
        reviews_list = Review.query.filter_by(book_id=book.id).all() #извлекаем отз. по id
        reviews_count = len(reviews_list)
        rating_sum = sum(review.rating for review in reviews_list)
        average_rating = rating_sum / reviews_count if reviews_count > 0 else 0 # вычистяет средний рейтинг
        reviews.append([reviews_count, average_rating])
    
    # Список жанров и изображений для отображения
    genres = Genre.query.all()
    images = Image.query.all()

    return render_template(
        'index.html', 
        books=books, 
        images=images, 
        genres=genres, 
        years=years, 
        pagination=pagination, 
        search_params=search_params(), 
        reviews=reviews
    )


@app.route('/image/<image_id>')
def image(image_id):
    image = Image.query.get(image_id)
    if image is None:
        abort(404)
    return send_from_directory(app.config['UPLOAD_FOLDER'], image.storage_filename)