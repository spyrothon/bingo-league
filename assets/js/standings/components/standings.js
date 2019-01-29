import { h, Component } from 'preact';
import { renderJoined } from '../util';
import { DateTime } from 'luxon';
import linkState from 'linkstate';

import { TeamStandings } from './team-standings';

export class Standings extends Component {
  render(props) {
    const {
      loading,
      matches,
      allTeams,
    } = props;

    if(loading) return <h1>Loading</h1>;

    return (
      <div class="columns">
        <div class="column is-7">
          <div class="box">
            <h2 class="title">Match History</h2>
          </div>
        </div>

        <div class="column is-5">
          <div class="box">
            <h2 class="title">Team Standings</h2>

            <TeamStandings matches={matches} allTeams={allTeams} />
          </div>
        </div>
      </div>
    );
  }
};
