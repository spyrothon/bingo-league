import { h, Component } from 'preact';

export class Navbar extends Component {
  render(props) {
    return (
      <nav class="navbar">
        <div class="container">
          <div class="navbar-brand">
            <span class="navbar-burger burger" data-target="primaryNav">
              <span></span>
              <span></span>
              <span></span>
            </span>
          </div>
        </div>
      </nav>
    );
  }
};
