'use strict';

//Обрабатывает событие выбора изображения для предварительного просмотра.
function imagePreviewHandler(event) {
     // Проверяем, выбран ли файл изображения
    if (event.target.files && event.target.files[0]) {
        let reader = new FileReader();
        
        // Устанавливаем обработчик события onload для загрузки файла
        reader.onload = function (e) {
            let img = document.querySelector('.background-preview > img');
             
            // Устанавливаем источник изображения в загруженный файл
            img.src = e.target.result;

            // Проверяем, скрыт ли элемент изображения
            if (img.classList.contains('d-none')) {
                let label = document.querySelector('.background-preview > label');

                // Скрываем элемент метки и показываем элемент изображения
                label.classList.add('d-none');
                img.classList.remove('d-none');
            }
        }
         // Читаем файл изображения в формате data URL
        reader.readAsDataURL(event.target.files[0]);
    }
}

// Открывает ссылку на основе цели события.
function openLink(event) {
    
     // Находим ближайший родительский элемент с классом 'row'
    let row = event.target.closest('.row');

    // Проверяем, есть ли у строки атрибут 'data-url'
    if (row.dataset.url) {

        // Перенаправляем на URL, указанный в атрибуте 'data-url'
        window.location = row.dataset.url;
    }
}



window.onload = function() { 
    // Получаем элемент поля фонового изображения
    let background_img_field = document.getElementById('background_img');
    if (background_img_field) {
          // Устанавливаем обработчик события onchange на функцию imagePreviewHandler
        background_img_field.onchange = imagePreviewHandler;
    }
     // Получаем все элементы с классом 'row' внутри '.courses-list'
    for (let course_elm of document.querySelectorAll('.courses-list .row')) {
        // Устанавливаем обработчик события onclick на функцию openLink для каждого элемента курса
        course_elm.onclick = openLink;
    }
}


document.addEventListener('DOMContentLoaded', function() {
    // Получаем элемент textarea с id 'description'
    var textarea = document.getElementById('description');
    // Создаем экземпляр EasyMDE и передаем ему элемент textarea
    var editor = new EasyMDE({ element: textarea });
});

document.addEventListener('DOMContentLoaded', function() {
     // Получаем элемент textarea с id 'text'
    var textarea = document.getElementById('text');
    var editor = new EasyMDE({ element: textarea });
});


  