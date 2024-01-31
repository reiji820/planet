document.addEventListener("turbolinks:load", function() {
  const editButtons = document.querySelectorAll('.edit-schedule');

  editButtons.forEach(button => {
    button.addEventListener('click', function(event) {
      event.preventDefault();

      const scheduleId = this.dataset.id;
      const planElement = document.getElementById(`schedule-plan-${scheduleId}`);
      const editForm = document.getElementById(`edit-form-${scheduleId}`);
      const timeSchedule = document.getElementById(`schedule-time-stamp-${scheduleId}`);
      const genreElement = document.getElementById(`schedule-genre-${scheduleId}`);  // ジャンル要素の取得

      if (planElement && editForm) {
        // 編集および削除ボタンを非表示にする
        button.style.display = 'none';  // 編集ボタンを非表示にする
        const deleteButton = document.querySelector(`.delete-schedule[data-id="${scheduleId}"]`);
        if (deleteButton) {
          deleteButton.style.display = 'none';  // 削除ボタンを非表示にする
        }

        timeSchedule.style.display = 'none';
        planElement.style.display = 'none';
        editForm.style.display = 'block';
        if (genreElement) {
          genreElement.style.display = 'none';  // ジャンル要素を非表示にする
        }

        // フォーム送信用のイベントリスナーを追加
        const saveButton = editForm.querySelector('input[type="submit"]');
        const saveButtonClickHandler = function() {
          // 編集および削除ボタンを再表示する
          button.style.display = 'inline-block';  // 編集ボタンを表示する
          if (deleteButton) {
            deleteButton.style.display = 'inline-block';  // 削除ボタンを表示する
          }

          // 編集フォームを非表示にし、プラン要素を表示する
          timeSchedule.style.display = 'block';
          planElement.style.display = 'block';
          editForm.style.display = 'none';
          if (genreElement) {
            genreElement.style.display = 'block';  // ジャンル要素を再表示する
          }

          // 画面の手動更新
          Turbolinks.visit(window.location.href, { action: 'replace' });

          // 複数のリスナーを防ぐためにイベントリスナーを削除する
          saveButton.removeEventListener('click', saveButtonClickHandler);
        };

        saveButton.addEventListener('click', saveButtonClickHandler);
      }
    });
  });
});
