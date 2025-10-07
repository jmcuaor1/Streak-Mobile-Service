// Efecto interactivo en el botón
document.getElementById("nextBtn").addEventListener("click", () => {
  const btn = document.getElementById("nextBtn");
  
  // Añade una clase para activar la animación CSS
  btn.classList.add("clicked");

  setTimeout(() => {
    alert("¡Explorando oportunidades laborales!");

    // Elimina la clase para volver al estado original
    // después de un breve momento para que la animación de vuelta no sea abrupta
    setTimeout(() => {
      btn.classList.remove("clicked");
    }, 300);
  }, 1200);
});
