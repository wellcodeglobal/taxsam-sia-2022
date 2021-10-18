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
    <li><a href="#Environment">Environment</a></li>
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
- ruby 3.0.2
- Rails 6.1.4.1
- Yarn 1.22.11
- Node v12.22.6

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

  NEW_RELIC_NAME_APP=""
  NEW_RELIC_LICENSE="d626813596683fbfde6ff0c817aad2832f8053e5"

  GOOGLE_ANALYTICS_KEY="UA-206526044-1"
  ```

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
