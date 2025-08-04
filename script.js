 const navbar = document.getElementById('navbar');

  window.addEventListener('scroll', () => {
    if (window.scrollY > 10) {
      navbar.classList.add('bg-white/10', 'backdrop-blur-md');
    } else {
      navbar.classList.remove('bg-white/10', 'backdrop-blur-md');
    }
  });
new Swiper(".mySwiper", {
  loop: true,
  loopedSlides: 4,
  autoplay: {
    delay: 0,
    disableOnInteraction: false,
  },
  speed: 3000,
  slidesPerView: "auto",
  spaceBetween: 30,
});


const openBtn = document.getElementById('openModal');
  const modal = document.getElementById('videoModal');
  const closeBtn = document.getElementById('closeModal');
  const iframe = document.getElementById('youtubePlayer');
  const videoURL = "https://www.youtube.com/embed/dX-5u-gNuHo?autoplay=1";

  openBtn.addEventListener('click', () => {
    iframe.src = videoURL;
    modal.classList.remove('hidden');
    modal.classList.add('flex');
  });

  closeBtn.addEventListener('click', () => {
    iframe.src = "";
    modal.classList.add('hidden');
    modal.classList.remove('flex');
  });

  // Close modal if clicked outside iframe
  modal.addEventListener('click', (e) => {
    if (e.target === modal) {
      iframe.src = "";
      modal.classList.add('hidden');
      modal.classList.remove('flex');
    }
  });