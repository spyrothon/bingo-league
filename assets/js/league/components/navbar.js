import { h, Component } from 'preact';

export class Navbar extends Component {
  render(props) {
    return (
      <nav class="navbar">
        <div class="container">
          <div class="navbar-brand">
            <a class="navbar-item navbar-brand-icon" href="/">
              <span class="brand-logo has-text-weight-bold">Bingo League</span>
            </a>
            <span class="navbar-burger burger" data-target="primaryNav">
              <span></span>
              <span></span>
              <span></span>
            </span>
          </div>

          <div class="navbar-menu" id="primaryNav">
            <div class="navbar-start">
              <a class="navbar-item" href="/matches">Matches</a>
              <a class="navbar-item" href="/teams">Teams</a>
              <a class="navbar-item" href="/players">Players</a>
            </div>
          </div>
        </div>
      </nav>
    );
  }
};
