const back = document.getElementById("back");
back.classList.add("d-block");

back.addEventListener("click", () => {
  window.history.back();
});

// when in home page don't show back button
document.addEventListener("DOMContentLoaded", () => {
  if (window.location.pathname === "/pages/homepage.jsp") {
    back.style.display = "none";
  } else {
    back.style.display = "block";
  }
});
