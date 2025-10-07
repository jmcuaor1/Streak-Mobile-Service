document.addEventListener('DOMContentLoaded', () => {
  const form = document.getElementById('add-post-form');
  const postButtonHeader = document.querySelector('.post-link');
  const postButtonFooter = document.querySelector('.btn-add');
  const backIcon = document.querySelector('.back-icon');
  
  // Inputs de archivo
  const imageUpload = document.getElementById('file-upload-image');
  const cameraUpload = document.getElementById('file-upload-camera');
  
  // Previsualización de imagen
  const imagePreviewContainer = document.getElementById('image-preview-container');
  let selectedFile = null;

  // Contador de caracteres
  const descriptionTextarea = document.getElementById('descripcion');
  const charCounter = document.getElementById('char-counter');
  const maxLength = descriptionTextarea.getAttribute('maxlength');

  // Simulación de envío de formulario
  form.addEventListener('submit', (e) => {
    e.preventDefault(); // Evita que el formulario se envíe de la manera tradicional
    const title = document.getElementById('titulo').value;
    const description = descriptionTextarea.value;

    if (title.trim() === '' || description.trim() === '') {
      alert('Por favor, completa el título y la descripción.');
      return;
    }

    // Simular estado de carga
    postButtonHeader.disabled = true;
    postButtonFooter.disabled = true;
    postButtonHeader.textContent = 'Publicando...';
    postButtonFooter.textContent = 'Publicando...';

    setTimeout(() => {
      alert(`Post "${title}" creado exitosamente. ¡Buen trabajo! 🚀`);
      
      // Restablecer formulario y estado de botones
      form.reset();
      removeImagePreview();
      charCounter.textContent = `0/${maxLength}`;
      postButtonHeader.disabled = false;
      postButtonFooter.disabled = false;
      postButtonHeader.textContent = 'Post';
      postButtonFooter.textContent = 'Añadir historia';

    }, 1500); // Simula una espera de 1.5 segundos
  });

  // Funcionalidad del botón de volver
  backIcon.addEventListener('click', () => {
    window.history.back();
  });

  // Lógica para previsualizar la imagen
  const handleFileSelect = (event) => {
    const file = event.target.files[0];
    if (file && file.type.startsWith('image/')) {
      selectedFile = file;
      const reader = new FileReader();
      reader.onload = (e) => {
        imagePreviewContainer.innerHTML = `
          <img src="${e.target.result}" alt="Previsualización de imagen">
          <button type="button" class="remove-image-btn" title="Quitar imagen">&times;</button>
        `;
        document.querySelector('.remove-image-btn').addEventListener('click', removeImagePreview);
      };
      reader.readAsDataURL(file);
    }
  };

  const removeImagePreview = () => {
    selectedFile = null;
    imageUpload.value = ''; // Resetea el input de archivo
    cameraUpload.value = '';
    imagePreviewContainer.innerHTML = '';
  };

  imageUpload.addEventListener('change', handleFileSelect);
  cameraUpload.addEventListener('change', handleFileSelect);

  // Lógica del contador de caracteres
  descriptionTextarea.addEventListener('input', () => {
    const currentLength = descriptionTextarea.value.length;
    charCounter.textContent = `${currentLength}/${maxLength}`;
  });
});