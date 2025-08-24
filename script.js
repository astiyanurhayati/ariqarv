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




var swiper = new Swiper(".mySwiper", {
  slidesPerView: 8,
  spaceBetween: 30,
  loop: true,
  speed: 4000, // kecepatan geser (besar = lambat)
  autoplay: {
    delay: 0, // supaya jalan terus tanpa jeda
    disableOnInteraction: false,
  },
  freeMode: true,
  freeModeMomentum: false,
  grabCursor: true,
  breakpoints: {
    0: {
      slidesPerView: 2,
    },
    480: {
      slidesPerView: 4,
    },
    768: {
      slidesPerView: 6,
    },
    1024: {
      slidesPerView: 8,
    },
  }
});



var swiper2 = new Swiper(".mySwiper2", {
  slidesPerView: 8,
  spaceBetween: 30,
  loop: true,
  rewind: true,
  autoplay: {
    delay: 1000,
    reverseDirection: true,
    disableOnInteraction: false,
  },
  breakpoints: {
    0: {
      slidesPerView: 4, // untuk layar <= 480px
    },
    480: {
      slidesPerView: 4,
    },
    640: {
      slidesPerView: 6,
    },
    1024: {
      slidesPerView: 8, // untuk layar >= 1024px
    },
  }
});


 const phone = "6282114855270";
    const message = `Halo saya tertarik untuk booking design sprint & development. 
Boleh minta detail tentang paket :

- Standard Landing Page
- Pro Website / App
- Platinum Website / App 

Terima kasih.`;

    const messageStandar = `Halo saya tertarik untuk booking design sprint & development. 
Boleh minta detail tentang paket :

- Standard Landing Page`;

    const messagePro= `Halo saya tertarik untuk booking design sprint & development.
Boleh minta detail tentang paket :
- Pro website / App`;

    const messagePlatinum = `Halo saya tertarik untuk booking design sprint & development.
Boleh minta detail tentang paket :
- Platinum Website / App`;


    // Encode pesan biar aman di URL
    const encodedMessage = encodeURIComponent(message);
    const encodedStandar = encodeURIComponent(messageStandar);
    const encodedPlatinum = encodeURIComponent(messagePlatinum);
    const encoodePro = encodeURIComponent(messagePro);

    // Gabungkan jadi link wa.me
    const waUrl = `https://wa.me/${phone}?text=${encodedMessage}`;
    const standar = `https://wa.me/${phone}?text=${encodedStandar}`;
    const platinum = `https://wa.me/${phone}?text=${encodedPlatinum}`;
    const pro = `https://wa.me/${phone}?text=${encoodePro}`;

    // Set ke href <a>
    document.querySelectorAll(".waLink").forEach(el => {
      el.setAttribute("href", waUrl);
    });

    document.getElementById("standar").setAttribute("href", standar);
    document.getElementById("platinum").setAttribute("href", platinum);
    document.getElementById("pro").setAttribute("href", pro);
