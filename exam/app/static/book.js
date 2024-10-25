let deleteBookModal = document.querySelector('#deleteBook');

// Добавляем обработчик события "show.bs.modal"
deleteBookModal.addEventListener('show.bs.modal', function(event) {
    let form = document.querySelector('#deleteBookForm');
    // Устанавливаем атрибут "action" формы в значение из свойства "data-url" события
    form.action = event.relatedTarget.dataset.url;
    let bookName = document.querySelector('#bookName');
    // Устанавливаем текст содержимого элемента "bookName" в значение текста заголовка h4 элемента, ближайшего родителя с классом "row"
    bookName.textContent = event.relatedTarget.closest('.row').querySelector('h4').textContent;
});