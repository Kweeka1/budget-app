const expenseEls = document.querySelectorAll('.expense-item');
const carousel = document.querySelector('.carousel');
const items = carousel.querySelectorAll('.item');

const expenses = []

expenseEls.forEach((expenseEl) => {
    expenses.push({
        name: expenseEl.querySelector('.item-name').textContent,
        createdAt: expenseEl.querySelector('.item-created-at').textContent,
        amount: expenseEl.querySelector('.item-amount').textContent,
        date: new Date(expenseEl.querySelector('.item-created-at').textContent.split(" ").at(-1)),
        action: expenseEl.querySelector('form').action,
        value: parseFloat(expenseEl.querySelector('.item-amount').textContent.split(" ").at(-1).slice(1)),
        token: expenseEl.querySelector('form')["authenticity_token"].value
    })
})

const sortExpenses = () => {
    for (let i = 0; i < expenses.length; i++) {
        expenseEls[i].querySelector('.item-name').textContent = expenses[i].name
        expenseEls[i].querySelector('.item-created-at').textContent = expenses[i].createdAt
        expenseEls[i].querySelector('.item-amount').textContent = expenses[i].amount
        expenseEls[i].querySelector('form').action = expenses[i].action
        expenseEls[i].querySelector('form')["authenticity_token"].value = expenses[i].token
    }
}

console.log(expenses)

let activeItem = 1;

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

    debugger
    switch (activeItem) {
        case 0:
            expenses.sort((item1, item2) => item1.date > item2.date);
            sortExpenses();
            break;
        case 1:
            expenses.sort((item1, item2) => item1.date < item2.date);
            sortExpenses();
            break;
        case 2:
            expenses.sort((item1, item2) => item1.value > item2.value);
            sortExpenses();
            break;
        case 3:
            expenses.sort((item1, item2) => item1.value < item2.value);
            sortExpenses();
            break;
    }
}