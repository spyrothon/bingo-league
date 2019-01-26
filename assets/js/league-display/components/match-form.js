import { h, Component } from 'preact';
import linkState from 'linkstate';

class MatchForm extends Component {
  constructor(props) {
    super();

    const teams = props.league.teams;

    this.state = {
      availableTeams: teams,
      newMatch: {
        team1Id: null,
        team2Id: null
      }
    };
  };

  createMatch(ev) {
    ev.preventDefault();
    onCreateMatch(this.state.newMatch);
    return false;
  }

  render(props, state) {
    const { league } = props;
    const {
      availableTeams,
      newMatch
    } = state;

    console.log(state)

    return (
      <form class="form">
        <div class="field is-grouped">
          <div class="control is-expanded">
            <div class="select is-fullwidth">
              <select value={newMatch.team1Id} onChange={linkState(this, 'newMatch.team1Id')}>
                <option disabled value="">Select Team 1</option>
                { availableTeams.map((team) => (
                    <option key={team.id} value={team.id}>{team.name}</option>
                  ))
                }
              </select>
            </div>
          </div>

          <div class="control is-expanded">
            <div class="select is-fullwidth">
              <select value={newMatch.team2Id} onChange={linkState(this, 'newMatch.team2Id')}>
                <option disabled value="">Select Team 2</option>
                { availableTeams.map((team) => (
                    <option key={team.id} value={team.id}>{team.name}</option>
                  ))
                }
              </select>
            </div>
          </div>

          <div class="control">
            <input class="button is-primary" type="submit" value="Create Match" onClick={this.createMatch.bind(this)}/>
          </div>
        </div>
      </form>
    );
  }
}

export default MatchForm;
