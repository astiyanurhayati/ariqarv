const navbar = document.getElementById('navbar');

window.addEventListener('scroll', () => {
  if (window.scrollY > 10) {
    navbar.classList.add('bg-white/10', 'backdrop-blur-md');
  } else {
    navbar.classList.remove('bg-white/10', 'backdrop-blur-md');
  }
});




document.addEventListener("DOMContentLoaded", () => {
  const showMoreBtn = document.getElementById("show-more");
  const cards = document.querySelectorAll(".card-ar");

  showMoreBtn.addEventListener("click", () => {
    cards.forEach((card, index) => {
      // index mulai dari 0, jadi > 2 artinya mulai dari Card ke-4
      if (index > 2) {
        card.classList.toggle("hidden");
      }
    });



   

    // Toggle teks tombol
    if (showMoreBtn.textContent === "Show more") {
      showMoreBtn.textContent = "Show less";
    } else {
      showMoreBtn.textContent = "Show more";
    }
  });

  // Pas awal load, pastikan di mobile yang di-hide cuma setelah index 2
  if (window.innerWidth < 768) {
    cards.forEach((card, index) => {
      if (index > 2) card.classList.add("hidden");
    });
  }
});


