const button = document.querySelector('.button');
const formFinish = document.querySelector('.form_finish');

// buttonが押された時
button.addEventListener('click', function () {
    console.log(button);
    console.log(formFinish);
    formFinish.style.display = 'block';
});