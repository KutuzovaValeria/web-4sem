import hashlib
import uuid
import os
from werkzeug.utils import secure_filename
from models import Book, Image, Genre
from app import db, app


class BookFilter:
    def __init__(self, name=None, genre_ids=None, year=None, volume_from=None, volume_to=None, author=None):
        self.name = name
        self.genre_ids = genre_ids
        self.year = year
        self.volume_from = volume_from
        self.volume_to = volume_to
        self.author = author
        self.query = Book.query

    def perform(self):
        self.__filter_by_name()
        self.__filter_by_genres()
        self.__filter_by_year()
        self.__filter_by_volume()
        self.__filter_by_author()
        return self.query.order_by(Book.year.desc())

    def __filter_by_name(self):
        if self.name:
            self.query = self.query.filter(Book.name.ilike(f'%{self.name}%'))

    def __filter_by_genres(self):
        if self.genre_ids:
            self.query = self.query.filter(Book.genres.any(Genre.id.in_(self.genre_ids)))

    def __filter_by_year(self):
        if self.year:
            self.query = self.query.filter(Book.year == self.year)

    def __filter_by_volume(self):
        if self.volume_from:
            self.query = self.query.filter(Book.volume >= self.volume_from)
        if self.volume_to:
            self.query = self.query.filter(Book.volume <= self.volume_to)

    def __filter_by_author(self):
        if self.author:
            self.query = self.query.filter(Book.author.ilike(f'%{self.author}%'))


class ImageSaver:
    def __init__(self, file):
        self.file = file

    def save(self):

        self.img = self.__find_by_md5_hash()

        if self.img is not None:
            return self.img

        file_name = secure_filename(self.file.filename)

        self.img = Image(
            id=str(uuid.uuid4()),
            file_name=file_name,
            mime_type=self.file.mimetype,
            md5_hash=self.md5_hash)

        self.file.save(
            os.path.join(app.config['UPLOAD_FOLDER'], self.img.storage_filename))

        db.session.add(self.img)
        db.session.commit()

        return self.img

    def __find_by_md5_hash(self):

        self.md5_hash = hashlib.md5(self.file.read()).hexdigest()

        self.file.seek(0)

        return Image.query.filter(Image.md5_hash == self.md5_hash).first()
