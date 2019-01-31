import _ from 'lodash';
import { h, Component } from 'preact';
import { renderJoined } from '../util';
import { DateTime } from 'luxon';
import linkState from 'linkstate';

import { TeamStandings } from './team-standings';
import { OverallStats } from './overall-stats';
import { Match } from './match';

export class Standings extends Component {
  render(props) {
    const {
      loading,
      matches,
      allTeams,
    } = props;

    if(loading) return <h1>Loading</h1>;

    const [futureMatches, pastMatches] = _.chain(matches)
        .orderBy(['start_date'], ['desc'])
        .partition((match) => {
          return DateTime.fromISO(match.start_date).toMillis() > DateTime.utc().toMillis()
        })
        .value();

    return (
      <div class="columns is-centered">
        <div class="column is-4-tablet is-3">
          <h2 class="title has-text-right">Standings</h2>

          <TeamStandings matches={matches} allTeams={allTeams} />
          <OverallStats matches={matches} allTeams={allTeams} />
        </div>

        <div class="column is-narrow is-divider"></div>

        <div class="column is-8-tablet is-7 is-7-widescreen">
          <h2 class="title">Matches</h2>

          { futureMatches.length > 0 &&
            <div>
              <p class="is-uppercase has-text-grey has-margin-top-lg has-margin-bottom-md">Upcoming</p>
              { futureMatches.map((match) => <Match match={match} />) }
            </div>
          }

          { pastMatches.length > 0 &&
            <div>
              <p class="is-uppercase has-text-grey has-margin-top-lg has-margin-bottom-md">History</p>
              { pastMatches.map((match) => <Match match={match} />) }
            </div>
          }
        </div>
      </div>
    );
  }
};
