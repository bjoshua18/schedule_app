// Global variables
const dropArea = document.querySelector('.drag-area')
const message_div = dropArea.querySelector('.drag-area-message')
const default_message = 'Drag & Drop to Upload Image'
const upload_btn = dropArea.querySelector('.upload-btn')
const upload_input = dropArea.querySelector('.upload-input')
let image;

// Listeners
dropArea.addEventListener('dragover', (e) => {
  dropArea.classList.add('active')
  message_div.textContent = 'Release to Upload Image'
  e.preventDefault()
})
dropArea.addEventListener('dragleave', (e) => {
  dropArea.classList.remove('active')
  message_div.textContent = default_message
  e.preventDefault()
})
dropArea.addEventListener('drop', (e) => {
  image = e.dataTransfer.files[0]
  showFile()
  upload_input.files = e.dataTransfer.files
  e.preventDefault()
})
upload_btn.addEventListener('click', (e) => {
  upload_input.click()
  e.preventDefault()
})
upload_input.addEventListener('change', function() {
  image = this.files[0]
  showFile()
  dropArea.classList.add('active')
})

// Auxiliars functions
function showFile() {
  const validExtensions = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
  const imageType = image.type;

  if (validExtensions.includes(imageType)) {
    const fileReader = new FileReader()
    fileReader.onload = () => {
      const fileURL = fileReader.result
      const img_tag = `<img src="${fileURL}" alt="" />`
      dropArea.innerHTML = img_tag
      dropArea.appendChild(upload_input)
    }
    fileReader.readAsDataURL(image)
  } else {
    render_error_message()
    dropArea.classList.remove('active')
    setTimeout(reset_message, 3000)
  }
}

function render_error_message() {
  dropArea.classList.add('text-danger')
  message_div.innerText = 'This is not an Image!'
}

function reset_message() {
  dropArea.classList.remove('text-danger', 'active')
  message_div.innerText = default_message
}
