const carousel = document.querySelector('.carousel');

const items = carousel.querySelectorAll('.item');

let activeItem = 2;

const leftItem = carousel.querySelector('.left');
const rightItem = carousel.querySelector('.right');

const moveRight = () => {
    activeItem--;
    if (activeItem < 0) {
        activeItem = items.length - 1;
    }
    updateCarousel();
}

const moveLeft = () => {
    activeItem++;
    if (activeItem >= items.length) {
        activeItem = 0;
    }
    updateCarousel();
}

leftItem.addEventListener('click', moveRight);
rightItem.addEventListener('click', moveLeft);

function updateCarousel() {
    const leftIndex = activeItem - 1;
    const rightIndex = activeItem + 1;

    items.forEach((item) => {
        item.classList.remove('left', 'active', 'right');
        item.removeEventListener("click", moveRight);
        item.removeEventListener("click", moveLeft);
    });

    items[leftIndex]?.classList?.add('left');
    items[leftIndex]?.addEventListener("click", moveRight);

    items[activeItem].classList.add('active');

    items[rightIndex]?.classList?.add('right');
    items[rightIndex]?.addEventListener("click", moveLeft);
}