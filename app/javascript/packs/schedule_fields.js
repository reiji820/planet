document.addEventListener("turbolinks:load", () => {
  const addScheduleBtn = document.querySelector("#add_schedule");
  if (addScheduleBtn) { // addScheduleBtnが存在するかチェック
    addScheduleBtn.addEventListener("click", () => {
      const timeSchedulesContainer = document.querySelector("#time-schedules");
      const templateElement = document.querySelector("#time-schedules-template");
      if (timeSchedulesContainer && templateElement) { // timeSchedulesContainerとtemplateElementが存在するかチェック
        const template = templateElement.innerHTML.replace(/NEW_RECORD/g, new Date().getTime());
        // timeSchedulesContainerの最後にtemplateを挿入
        timeSchedulesContainer.insertAdjacentHTML("beforeend", template);
      }
    });
  }

  const timeSchedules = document.querySelector("#time-schedules");
  if (timeSchedules) { // timeSchedulesが存在するかチェック
    timeSchedules.addEventListener("click", (e) => {
      if (e.target.matches(".remove_schedule")) {
        e.preventDefault();
        e.target.closest(".nested-fields").remove();
      }
    });
  }
});
