import { h, Component } from 'preact';
import { renderJoined } from '../util';
import { DateTime } from 'luxon';
import linkState from 'linkstate';

import { TeamStandings } from './team-standings';
import { Match } from './match';

export class Standings extends Component {
  render(props) {
    const {
      loading,
      matches,
      allTeams,
    } = props;

    if(loading) return <h1>Loading</h1>;

    const futureMatches = matches.filter((match) => {
      return DateTime.fromISO(match.start_date).toMillis() > DateTime.utc().toMillis()
    });

    return (
      <div class="columns">
        <div class="column is-3-desktop">
          <h2 class="title">Standings</h2>

          <TeamStandings matches={matches} allTeams={allTeams} />
        </div>

        <div class="column is-5-desktop">
          <h2 class="title">Match History</h2>

          { matches.map((match) => <Match match={match} />) }
        </div>

        <div class="column is-4-desktop">
          <h2 class="title">Upcoming Matches</h2>

          { futureMatches.map((match) => <Match match={match} />) }
        </div>
      </div>
    );
  }
};
