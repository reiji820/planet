class RenamePlaceOfBirthToResidenceInUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :place_of_birth, :residence
  end
end
