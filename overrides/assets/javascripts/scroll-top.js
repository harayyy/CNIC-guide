/* 左上角标识随滚动变身：顶部为白色圆点，下滑后变为向上箭头；点击平滑回到顶部 */
document$.subscribe(function () {
  var root = document.documentElement;
  var logo = document.querySelector("a.md-header__button.md-logo");

  function update() {
    root.classList.toggle("md-scrolled", window.scrollY > 8);
  }
  window.addEventListener("scroll", update, { passive: true });
  update();

  if (logo) {
    logo.addEventListener("click", function (ev) {
      var isHome = location.pathname === "" ||
        location.pathname === "/" ||
        /\/index\.html?$/.test(location.pathname);
      if (!isHome && logo.href) {
        var target = new URL(logo.href, location.href);
        isHome = target.origin === location.origin &&
          target.pathname === location.pathname;
      }
      if (isHome) {
        ev.preventDefault();
        window.scrollTo({ top: 0, behavior: "smooth" });
      }
    });
  }
});
