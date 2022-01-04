<br />
<div align="center">
  <a href="https://wellcode.io">
    <img src="https://d2sb5cns5ryu46.cloudfront.net/wp-content/uploads/2021/01/HEADER-WELLCODE-COLOR-500x94.png" alt="Logo" width="300" height="60">
  </a>

  <h3 align="center">-README TEMPLATE PROJECT WELLCODE-</h3>

  <p align="center">
    This is Template to jumpstart your projects!    
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#environment">Environment</a></li>
    <li><a href="#deploy-server">Deploy Server</a></li>
    <li><a href="#setup-local-project-for-deploy-server">Setup Local Project for Deploy Server</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- GETTING STARTED -->
## Getting Started

Download dan clone this project to your local and change :
- `database.yml`
- `asset_sync.yml`
- Replace all `TEMPLATE_PROJECT` from `app/views/*` to your project name.

### Prerequisites

You need to install :
- ruby
- Yarn 
- postgresql
- git
- nginx
- nodejs
- npm

### Installation

1. Go to yout project directory
2. Clone the repo
   ```sh
   git clone https://github.com/wellcodeglobal/template_project.git
   ```
3. install rails and bundle Instal
   ```sh
   bundle install
   ```
4. install yarn modules
   ```sh
   yarn install
   ```
5. migrate database
   ```sh
   rails db:migrate
   ```
5. create file `.env` and Setup with Environment below

<p align="right">(<a href="#top">back to top</a>)</p>

### Environment
  ```
  HOST="localhost"
  PORT="3000"

  ASSET_HOST_NAME=""

  S3_ACCESS_KEY=""
  S3_SECRET_KEY=""
  S3_REGION=""
  S3_MEDIA_BUCKET=""
  
  TWILIO_ACCOUNT_SID=""
  TWILIO_AUTH_TOKEN=""
  TWILIO_PHONE_NUMBER=""

  NEW_RELIC_NAME_APP=""
  NEW_RELIC_LICENSE="d626813596683fbfde6ff0c817aad2832f8053e5" <<-CHANGE THIS WITH New Relic project>>

  GOOGLE_ANALYTICS_KEY="UA-206526044-1" <<-CHANGE THIS WITH GA project>>
  ```

### Deploy Server
  Follow this article for setup server deployment with capistrano :
  <a href="https://webdevchallenges.com/how-to-deploy-a-rails-6-application-with-capistrano">
  How to Deploy a Rails 6 Application with Capistrano, Nginx, Puma, Postgresql, LetsEncrypt on Ubuntu 20.04`
  </a>
  ```
  https://webdevchallenges.com/how-to-deploy-a-rails-6-application-with-capistrano
  ```  

  1. Access SSH
    access ssh to server production and prepare all requirement for server

  2. Folder requirement
    create folder to install in server production
    ```
    mkdir -p /home/ubuntu/template-project
    mkdir -p /home/ubuntu/template-project/shared/tmp/sockets
    ```

  3. Setup Postgre sql and database
  setup the database postgresql and provide the url :
  ```
  1. sudo -u postgres psql
  2. create database template_project;
  3. \password postgres
  ```

  and result url for user postgres and password postgres in localhost env to be like this :
  ```
  postgresql://postgres@localhost:5432/template_project
  ```
  
  4. setup puma service and nginx :
  check if there is messages like `Failed to restart puma_mysite_production.service: Unit puma_mysite_production.service not found.`

  create service for puma 
  ```
  vi /etc/systemd/system/puma_template-project_production.service
  ```
  
  and code script for service puma 
  ```
  [Unit]
  Description=Puma HTTP Server for template_project (production)
  After=network.target

  [Service]
  Type=simple
  User=ubuntu
  WorkingDirectory=/home/ubuntu/template-project/current
  ExecStart=/home/ubuntu/.rbenv/bin/rbenv do bundle exec puma -C /home/ubuntu/template-project/shared/puma.rb
  ExecReload=/bin/kill -TSTP $MAINPID
  StandardOutput=append:/home/ubuntu/template-project/current/log/puma.access.log
  StandardError=append:/home/ubuntu/template-project/current/log/puma.error.log
  Restart=always
  SyslogIdentifier=puma

  [Install]
  WantedBy=multi-user.target
  ```

### Setup Nginx
  1. make file for site nginx
  ```
  vi /etc/nginx/sites-available/template-project.wellcode.io  
  ```

  2. setup nginx with this code :
  ```
  upstream template-project.wellcode.io {
    server unix:///home/ubuntu/template-project/shared/tmp/sockets/template-project-puma.sock;
  }

  server {
    server_name template-project.wellcode.io;
    client_max_body_size 50M;

    root /home/ubuntu/template-project/current/public;
    access_log /home/ubuntu/template-project/current/log/nginx.access.log;
    error_log /home/ubuntu/template-project/current/log/nginx.error.log info;

    location / {
      proxy_set_header Host $host;
      proxy_set_header X-Forwarded-Host $host;
      proxy_set_header X-Forwarded-Ssl on;

      proxy_buffer_size          128k;
      proxy_buffers              4 256k;
      proxy_busy_buffers_size    256k;
    }
  }
  ```

  3. and link file to site-enabled
  ```
  sudo ln -s /etc/nginx/sites-available/template-project.wellcode.io /etc/nginx/sites-enabled/template-project.wellcode.io
  ```
  
### Setup Local Project for Deploy Server
  and the you can follow this step for local project :

  1. run bundle install
  2. run cap install
  3. replace code template project for deployment with your project in `config/deploy.rb`
  ```  
  server 'TEMPLATE_PROJECT.com', port: 22, roles: [:web, :app, :db], primary: true
  set :application, "TEMPLATE_PROJECT"
  set :repo_url, "git@github.com:wellcodeglobal/template_project.git"
  ```

  4. setup pub ssh with your project ssh key public server, and change the path in `config/deploy.rb`
  ```
  set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/template_project.pub) }
  ```

  4. Copy your master.key to the shared dir.
  ```
  ssh rails@mysite.com
  mkdir -p apps/mysite/shared/config
  # back on your machine
  cd mysite
  scp config/master.key rails@mysite.com:apps/mysite/shared/config
  ```

  5. Adjust your production database `config/database.yml` file and set env for deployment in `config/deploy.rb`.
  ```
  set :default_env, {
    PATH: '$HOME/.nvm/versions/node/v14.16.0/bin/:$PATH',  
    NODE_ENVIRONMENT: 'production',
    DATABASE_URL: "postgresql://postgres:postgres@localhost:5432/template_project"
  }
  ```  

  6. try to deploy to production with actual server.
  ```
  cap production deploy
  ```

  access log for capistrano run :
  ```
  cap production rails:logs
  ```

  7. Assets Sync
  to turn on assets sync please see the document in `lib/tasks/asset_sync.rake`
  <p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the template to be such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/template_project`)
3. Commit your Changes (`git commit -m 'Add some template_project'`)
4. Push to the Branch (`git push origin feature/template_project`)
5. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- LICENSE -->
## License

Distributed under the WELLCODE.IO License.

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Wellcode.io - (https://wellcode.io/) - admin@wellcode.io

Project Link: [https://github.com/wellcodeglobal/template_project.git](https://github.com/wellcodeglobal/template_project.git)

<p align="right">(<a href="#top">back to top</a>)</p>
