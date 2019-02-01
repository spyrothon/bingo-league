import _ from 'lodash';
import { h, Component } from 'preact';
import { renderJoined } from '../util';
import { DateTime } from 'luxon';
import linkState from 'linkstate';

import { TeamStandings } from './team-standings';
import { OverallStats } from './overall-stats';
import { MatchList } from './match-list';

export class League extends Component {
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
        <div class="column is-4-tablet is-4-desktop is-3-widescreen">
          <div class="has-margin-bottom-lg">
            <p class="is-uppercase has-text-grey has-margin-bottom-md">Team Standings</p>
            <TeamStandings matches={matches} allTeams={allTeams} />
          </div>

          <div class="has-margin-bottom-lg">
            <p class="is-uppercase has-text-grey has-margin-bottom-md">League Statistics</p>
            <OverallStats matches={matches} allTeams={allTeams} />
          </div>
        </div>

        <div class="column is-narrow is-divider"></div>

        <div class="column is-8-tablet is-7 is-7-widescreen">
          <div class="has-margin-bottom-lg">
            <p class="is-uppercase has-text-grey has-margin-bottom-md">Upcoming Matches</p>
            <MatchList matches={futureMatches} maxInitialDisplayed={3} />
          </div>

          <div class="has-margin-bottom-lg">
            <p class="is-uppercase has-text-grey has-margin-bottom-md">Past Matches</p>
            <MatchList matches={pastMatches} maxInitialDisplayed={30} />
          </div>
        </div>
      </div>
    );
  }
};
