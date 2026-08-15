/* 顶部第二行导航高亮跟随当前页面（instant 导航切换后也会自动更新） */
document$.subscribe(function () {
  var links = document.querySelectorAll(".isc-topnav a");
  if (!links.length) return;

  var rawPath = location.pathname || "";
  var path;
  try {
    path = decodeURIComponent(rawPath);
  } catch (e) {
    path = rawPath;
  }
  var isHome = path === "/" || path === "" || /\/index\.html?$/.test(path);

  var prefixes = {
    "初试准备": "/初试准备/",
    "复试准备": "/复试准备/",
    "毕业去向收集": "/毕业去向/",
    "上岸经验分享": "/上岸经验分享/",
    "贡献者名单": "/CONTRIBUTORS/",
    "免责声明": "/免责声明/"
  };

  links.forEach(function (a) {
    var key = a.getAttribute("data-nav") || "";
    var active = false;
    if (key === "home") {
      active = isHome;
    } else if (prefixes[key]) {
      active = path.indexOf(prefixes[key]) !== -1;
    }
    a.classList.toggle("active", active);
  });
});
