import { h, Component } from 'preact';
import MatchForm from './match-form.js';
import MatchHistory from './match-history.js';
import TeamStandings from './team-standings.js';

class LeagueDisplay extends Component {
  constructor(props) {
    super();
  }

  render(props, state) {
    const {
      league,
      matchesById,
      teamsById,
      loading,
      createMatch
    } = props;

    if(loading) return <h1>Loading</h1>;

    const matches = Object.values(matchesById);
    const teams = Object.values(teamsById);

    return (
      <div>
        <h1 class="title is-2 has-margin-bottom-lg">{name}</h1>

        <div class="columns">
          <div class="column is-4-desktop">
            <div class="box">
              <h2 class="title">Team Standings</h2>
              <TeamStandings teams={teams} />
            </div>
          </div>

          <div class="column is-8-desktop">
            <div class="box">
              <h2 class="title">Match History</h2>
              <MatchHistory matches={matches} />
            </div>

            <div class="box">
              <h2 class="title">New Match</h2>
              <MatchForm league={league} teams={teams} onSubmit={createMatch} />
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default LeagueDisplay;
