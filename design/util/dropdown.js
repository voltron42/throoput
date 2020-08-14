function toggleDropdown(id) {
  let dropdown = document.getElementById(id);
  if (dropdown.classList.contains("show")) {
    dropdown.classList.remove("show");
  } else {
    dropdown.classList.add("show");
  }
}
