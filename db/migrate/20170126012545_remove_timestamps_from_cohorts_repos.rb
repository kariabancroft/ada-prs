class RemoveTimestampsFromCohortsRepos < ActiveRecord::Migration
  def change
    remove_column :cohorts_repos, :created_at, :datetime, null: false
    remove_column :cohorts_repos, :updated_at, :datetime, null: false
  end
end
