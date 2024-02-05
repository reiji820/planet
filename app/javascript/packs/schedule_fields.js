document.addEventListener("turbolinks:load", () => {
  const addScheduleBtn = document.querySelector("#add_schedule");
  addScheduleBtn.addEventListener("click", () => {
    const timeSchedulesContainer = document.querySelector("#time-schedules");
    const template = document.querySelector("#time-schedules-template").innerHTML.replace(/NEW_RECORD/g, new Date().getTime());
    // timeSchedulesContainerの最後にtemplateを挿入
    timeSchedulesContainer.insertAdjacentHTML("beforeend", template);
  });

  document.querySelector("#time-schedules").addEventListener("click", (e) => {
    if (e.target.matches(".remove_schedule")) {
      e.preventDefault();
      e.target.closest(".nested-fields").remove();
    }
  });
});
