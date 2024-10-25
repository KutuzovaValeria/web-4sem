import os
import sqlalchemy as sa
from werkzeug.security import check_password_hash, generate_password_hash
from flask_login import UserMixin
from flask import url_for, current_app
from app import db
from users_policy import UsersPolicy


class Book(db.Model):
    __tablename__ = 'books'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text, nullable=False)
    year = db.Column(db.Integer, nullable=False)
    publisher = db.Column(db.String(100), nullable=False)
    author = db.Column(db.String(100), nullable=False)
    volume = db.Column(db.Integer, nullable=False)

    rating_sum = db.Column(db.Integer, nullable=False, default=0)
    rating_num = db.Column(db.Integer, nullable=False, default=0)

    id_image = db.Column(db.String(100), db.ForeignKey(
        'images.id', ondelete='CASCADE'))
    genres = db.relationship(
        'Genre', secondary='book_genre', backref=db.backref('books', lazy='dynamic'))

    def __repr__(self):
        return f'<Book {self.name}>'

    @property
    def rating(self):
        if self.rating_num > 0:
            return self.rating_sum / self.rating_num
        return 0


class Genre(db.Model):
    __tablename__ = 'genres'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False, unique=True)

    def __repr__(self):
        return f'<Genre {self.name}>'


class BookGenre(db.Model):
    __tablename__ = 'book_genre'

    book_id = db.Column(db.Integer, db.ForeignKey(
        'books.id', ondelete='CASCADE'), primary_key=True)
    genre_id = db.Column(db.Integer, db.ForeignKey(
        'genres.id', ondelete='CASCADE'), primary_key=True)

    book = db.relationship('Book', backref=db.backref(
        'book_genres', cascade='all, delete-orphan'))
    genre = db.relationship('Genre', backref=db.backref(
        'book_genres', cascade='all, delete-orphan'))

    def __repr__(self):
        return f'<BookGenre book_id={self.book_id} genre_id={self.genre_id}>'


class Image(db.Model):
    __tablename__ = 'images'

    id = db.Column(db.String(100), primary_key=True)
    file_name = db.Column(db.String(100), nullable=False)
    mime_type = db.Column(db.String(100), nullable=False)
    md5_hash = db.Column(db.String(100), nullable=False, unique=True)

    @property
    def storage_filename(self):
        _, ext = os.path.splitext(self.file_name)
        return str(self.id) + ext

    @property
    def url(self):
        return url_for('image', image_id=self.id)

    def __repr__(self):
        return f'<Image {self.file_name}>' 


class Review(db.Model):
    __tablename__ = 'reviews'

    id = db.Column(db.Integer, primary_key=True)
    rating = db.Column(db.Integer, nullable=False)
    text = db.Column(db.Text, nullable=False)
    created_at = db.Column(db.DateTime,
                           nullable=False,
                           server_default=sa.sql.func.now())

    book_id = db.Column(db.Integer, db.ForeignKey(
        'books.id', ondelete='CASCADE'))
    user_id = db.Column(db.Integer, db.ForeignKey(
        'users.id', ondelete='CASCADE'))

    book = db.relationship('Book')
    user = db.relationship('User')

    def __repr__(self):
        return f'<Review {self.id}>' 


class User(db.Model, UserMixin):
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key=True)
    last_name = db.Column(db.String(100), nullable=False)
    first_name = db.Column(db.String(100), nullable=False)
    middle_name = db.Column(db.String(100))
    login = db.Column(db.String(100), unique=True, nullable=False)
    password_hash = db.Column(db.String(200), nullable=False)

    role_id = db.Column(db.Integer, db.ForeignKey('roles.id'))

    def init(self, user_id, user_login, role_id):
        self.id = user_id
        self.login = user_login
        self.role_id = role_id

    def is_admin(self):
        return self.role_id == current_app.config['ADMIN_ROLE_ID']

    def is_moder(self):
        return self.role_id == current_app.config['MODER_ROLE_ID']

    def can(self, action, record=None):
        users_policy = UsersPolicy(record)
        method = getattr(users_policy, action, None)
        if method:
            return method()
        return False

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

    @property
    def full_name(self):
        return ' '.join([self.last_name, self.first_name, self.middle_name or ''])

    def __repr__(self):
        return f'<User {self.login}>'


class Role(db.Model):
    __tablename__ = 'roles'

    id = db.Column(db.Integer, primary_key=True)
    role_name = db.Column(db.Text, nullable=False)
    role_description = db.Column(db.Text, nullable=False)

    def __repr__(self):
        return f'<Review {self.id}>'

