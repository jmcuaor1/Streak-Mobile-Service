document.addEventListener('DOMContentLoaded', () => {
  const prevBtns = document.querySelectorAll(".btn-prev");
  const nextBtns = document.querySelectorAll(".btn-next");
  const progress = document.getElementById("progress");
  const formSteps = document.querySelectorAll(".form-step");
  const progressSteps = document.querySelectorAll(".progress-step");
  const form = document.getElementById("job-form");

  let formStepsNum = 0;

  nextBtns.forEach((btn) => {
    btn.addEventListener("click", (e) => {
      e.preventDefault();

      // Si estamos en el primer paso, redirigimos a la página de resultados
      if (formStepsNum === 0) {
        const puesto = document.getElementById('puesto').value;
        const tipoLugar = document.getElementById('tipoLugar').value;

        if (puesto.trim() === "") {
          alert("Por favor, introduce un puesto de trabajo para buscar.");
          return;
        }

        // Construir la URL con parámetros de búsqueda y redirigir
        const query = `?puesto=${encodeURIComponent(puesto)}&tipoLugar=${encodeURIComponent(tipoLugar)}`;
        window.location.href = `Results.html${query}`;
      } else {
        // Lógica para los siguientes pasos (si se reutiliza el formulario)
        formStepsNum++;
        updateFormSteps();
        updateProgressbar();
      }
    });
  });

  prevBtns.forEach((btn) => {
    btn.addEventListener("click", (e) => {
      e.preventDefault();
      formStepsNum--;
      updateFormSteps();
      updateProgressbar();
    });
  });

  function updateFormSteps() {
    formSteps.forEach((formStep) => {
      formStep.classList.contains("form-step-active") &&
        formStep.classList.remove("form-step-active");
    });

    formSteps[formStepsNum].classList.add("form-step-active");
  }

  function updateProgressbar() {
    progressSteps.forEach((progressStep, idx) => {
      if (idx < formStepsNum + 1) {
        progressStep.classList.add("progress-step-active");
      } else {
        progressStep.classList.remove("progress-step-active");
      }
    });

    const progressActive = document.querySelectorAll(".progress-step-active");
    progress.style.width =
      ((progressActive.length - 1) / (progressSteps.length - 1)) * 100 + "%";
  }

  form.addEventListener('submit', (e) => {
    e.preventDefault();
    const formData = new FormData(form);
    const data = Object.fromEntries(formData.entries());
    
    // Recopilando datos de todos los campos
    data.puesto = document.getElementById('puesto').value;
    data.tipoLugar = document.getElementById('tipoLugar').value;
    data.empresa = document.getElementById('empresa').value;
    data.tipoEmpleo = document.getElementById('tipoEmpleo').value;
    data.descripcion = document.getElementById('descripcion').value;

    alert(`✅ Empleo publicado exitosamente:\n\n${JSON.stringify(data, null, 2)}`);
    // Aquí podrías enviar los datos a un servidor
    // form.submit();
  });
});
  };

  // Validación simple
  if (!empleo.puesto) {
    alert("Por favor ingresa al menos el puesto de trabajo.");
    return;
  }

  // Mostrar los datos ingresados
  alert(`✅ Empleo agregado:\n\n${JSON.stringify(empleo, null, 2)}`);
}
