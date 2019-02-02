import { h, Component } from 'preact';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

export class Navbar extends Component {
  render(props) {
    return (
      <nav class="navbar">
        <div class="container">
          <div class="navbar-brand">
            <p class="navbar-item has-text-white">
              <h2 class="header">Bingo League</h2>
            </p>

            <a class="navbar-item" href="https://discord.gg/fCvfnfk" target="_blank" rel="nofollow noopener">
              <span class="icon"><FontAwesomeIcon icon={['fab', "discord"]} /></span>
            </a>

            <a class="navbar-item" href="https://twitch.tv/spyrothon" target="_blank" rel="nofollow noopener">
              <span class="icon"><FontAwesomeIcon icon={['fab', "twitch"]} /></span>
            </a>

            <a class="navbar-item" href="https://twitter.com/spyrothon" target="_blank" rel="nofollow noopener">
              <span class="icon"><FontAwesomeIcon icon={['fab', "twitter"]} /></span>
            </a>

            <a class="navbar-item" href="https://www.youtube.com/channel/UCq-pkx-6-BB1Ns7ETmzY6-g" target="_blank" rel="nofollow noopener">
              <span class="icon"><FontAwesomeIcon icon={['fab', "youtube"]} /></span>
            </a>
          </div>
        </div>
      </nav>
    );
  }
};
