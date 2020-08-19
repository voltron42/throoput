function selectTab(tabIdMap,tabBtnId,activeClass,disabledClass) {
  let domReducer = ((out,id) => {
    out[id] = document.getElementById(id);
    return out;
  });
  let buttons = Object.keys(tabIdMap).reduce(domReducer,{});
  let panes = Object.values(tabIdMap).reduce(domReducer,{});
  let activeButton = Object.entries(buttons).filter((entry) => {
    return entry[1].classList.contains(activeClass);
  })[0][1];
  activeButton.classList.remove(activeClass);
  activeButton.classList.add(disabledClass);
  let activePane = Object.entries(panes).filter((entry) => {
    return !entry[1].classList.contains("hide");
  })[0][1].classList.add("hide");
  let nextButton = buttons[tabBtnId];
  nextButton.classList.remove(disabledClass);
  nextButton.classList.add(activeClass);
  let nextPane = panes[tabIdMap[tabBtnId]];
  nextPane.classList.remove("hide");
}
