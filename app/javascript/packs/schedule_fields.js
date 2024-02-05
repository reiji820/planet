document.addEventListener("turbolinks:load", () => {
  // タイムスケジュールを追加する機能
  const addScheduleBtn = document.querySelector("#add_schedule");
  addScheduleBtn.addEventListener("click", () => {
    const timeSchedulesContainer = document.querySelector("#time-schedules");
    // 現在時刻をミリ秒で取得してユニークなIDとして使用
    const uniqueId = new Date().getTime();
    const template = document.querySelector("#time-schedules-template").innerHTML.replace(/NEW_RECORD/g, uniqueId);
    // timeSchedulesContainerの最後にtemplateを挿入
    timeSchedulesContainer.insertAdjacentHTML("beforeend", template);
  });

  // 削除ボタンの機能を動的に追加された要素に対しても適用
  document.querySelector("#time-schedules-container").addEventListener("click", (e) => {
    if (e.target.matches(".remove_schedule")) {
      e.preventDefault();
      e.target.closest(".nested-fields").remove();
    }
  });
});
