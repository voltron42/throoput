document.addEventListener('DOMContentLoaded', (event) => {

  function handleDragStart(e) {
    this.style.opacity = '1';

    let column = this.parentElement;
    let container = column.parentElement;
    e.dataTransfer.effectAllowed = 'move';
    e.dataTransfer.setData('text/html', JSON.stringify({
      dragId:this.id,
      columnId:column.id,
      containerId:container.id
    }));
  }

  function handleDragOver(e) {
    if (e.preventDefault) {
      e.preventDefault();
    }

    e.dataTransfer.dropEffect = 'move';

    return false;
  }

  function handleDragEnter(e) {
    this.classList.add('over');
  }

  function handleDragLeave(e) {
    this.classList.remove('over');
  }

  function handleDrop(e) {
    if (e.stopPropagation) {
      e.stopPropagation(); // stops the browser from redirecting.
    }

    let data = JSON.parse(e.dataTransfer.getData('text/html'));

    if (this.id != data.containerId) {
      let srcColumn = document.getElementById(data.columnId);
      let drag = document.getElementById(data.dragId);
      let targetColumn = this.querySelector(".flex-column");
      srcColumn.removeChild(drag);
      targetColumn.appendChild(drag);
    }

    return false;
  }

  function handleDragEnd(e) {

    document.querySelectorAll('.drop-target').forEach((item) => {
      item.classList.remove('over');
    });
  }

  document.querySelectorAll('.draggable').forEach((item) => {
    item.addEventListener('dragstart', handleDragStart, false);
  });
  document.querySelectorAll('.drop-target').forEach((item) => {
    item.addEventListener('dragenter', handleDragEnter, false);
    item.addEventListener('dragover', handleDragOver, false);
    item.addEventListener('dragleave', handleDragLeave, false);
    item.addEventListener('drop', handleDrop, false);
    item.addEventListener('dragend', handleDragEnd, false);
  });
});
