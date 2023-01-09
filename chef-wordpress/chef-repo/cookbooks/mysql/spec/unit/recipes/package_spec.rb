require 'spec_helper'

#Podemos también generar dinámicamente los casos de prueba para múltiples plataformas utilizando código Ruby.
#En este ejemplo se itera por la lista de plataformas y versiones, y se generan los casos de prueba dinámicamente en función de ellos,
#cada uno define las expectativas de los paquetes necesarios que se instalarán.

# Echar un ojo a https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md
# para que que versiones son soportadas. Por ejemplo: Debian 8.11 no, y salta error
#ChefSpec::SoloRunner.new  => hace que dinamicamente todo sea  node.normal['mysql']['install_method'] = 'package'
# a ver si existe ese metodo de instalacion

describe 'mysql::package' do
  package_checks = {
    'ubuntu' => {
      '20.04' => ['mysql-server'],
    }
  }

  package_checks.each do |platform, versions|
    versions.each do |version, packages|
      packages.each do |package_name|
        it "should install #{package_name} on #{platform} #{version}" do
          chef_run = ChefSpec::SoloRunner.new(platform: platform, version: version, file_cache_path: '/var/chef/cache') do |node|
            node.normal['mysql']['install_method'] = 'package'
          end.converge(described_recipe)
          Chef::Log.warn" package_name = #{package_name}"
          expect(chef_run).to install_package(package_name)
        end
      end
    end
  end

end
