// メニュー操作

// トグルリスナーを追加してクリックをリッスンする
document.addEventListener("turbo:load", ()=> {
    let hamburger = document.querySelector("#hamburger");
    hamburger.addEventListener("click", (event)=> {
    event.preventDefault();
    let menu = document.querySelector("#navbar-menu");
    menu.classList.toggle("collapse");
    });
    let account = document.querySelector("#account");
    account.addEventListener("click", (event)=> {
    event.preventDefault();
    let menu = document.querySelector("#dropdown-menu");
    menu.classList.toggle("active");
    });
});
