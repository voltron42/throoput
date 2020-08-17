function toggleClass(className,ids) {
  ids.forEach((id) => {
    let classList = document.getElementById(id).classList;
    if (classList.contains(className)) {
      classList.remove(className);
    } else {
      classList.add(className);
    }
  });
}
