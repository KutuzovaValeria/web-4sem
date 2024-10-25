import os

SECRET_KEY = '1rpwdertwe294rodijkxcdfijcmdsjf3r3404343dfdkfnsdwe4f'

SQLALCHEMY_DATABASE_URI = f'mysql+mysqlconnector://std_2641_exam:asdasdasd@std-mysql.ist.mospolytech.ru:3306/std_2641_exam?&collation=utf8mb4_general_ci'
SQLALCHEMY_TRACK_MODIFICATIONS = False
SQLALCHEMY_ECHO = True

ADMIN_ROLE_ID = 1
MODER_ROLE_ID = 2

UPLOAD_FOLDER = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'media', 'images')