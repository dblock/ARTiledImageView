workspace 'ARTiledImageView'
inhibit_all_warnings!

target "Demo" do
    pod 'ARTiledImageView', :path => 'ARTiledImageView.podspec'

    target 'IntegrationTests' do
      inherit! :search_paths
      
      pod 'Specta'
      pod 'Expecta'
      pod 'FBSnapshotTestCase', :subspecs => ["Core"]
      pod 'Expecta+Snapshots'
    end
end

