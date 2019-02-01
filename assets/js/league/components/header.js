import { h, Component } from 'preact';

import { Navbar } from './navbar';

export class Header extends Component {
  render(props) {
    const { children } = props;

    return (
      <div class="hero is-dark is-bold is-small">
        <div class="hero-head">
          <Navbar />
        </div>

        <div class="hero-body">
          <div class="container content">
            <h1 class="title header">Spyro 2 Bingo League</h1>
            <p class="is-size-5">
              In Bingo races, everybody gets the same randomly generated 5x5 card of objectives. To finish the race, you must complete objectives in a line. Once you get a full row, column, or diagonal, you are done.
            </p>

            <p class="is-size-5">
              You get to choose which objectives you want to complete, and avoid the ones you do not want to do. Several games have Bingo. Bingo tends to work well for games that can be open-ended and require route planning.
            </p>
          </div>
        </div>

        <div class="hero-foot">
          <nav class="tabs is-centered is-boxed has-margin-top-md">
            <div class="container">
              {children}
            </div>
          </nav>
        </div>
      </div>
    );
  }
};
