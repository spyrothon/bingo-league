import _ from 'lodash';
import { h, Component } from 'preact';

import { Match } from './match';

export class MatchList extends Component {
  constructor(props) {
    super(props);
    this.state = {
      isExpanded: false
    };
  }

  toggleExpanded(newState) {
    this.setState({ isExpanded: newState });
  }

  render(props, state) {
    const { matches, maxInitialDisplayed } = props;
    const { isExpanded } = state;

    const displayedMatches = isExpanded ? matches : _.take(matches, maxInitialDisplayed);

    console.log(displayedMatches)

    const hiddenMatchesCount = matches.length - displayedMatches.length;

    return (
      <div class="match-list">
        { displayedMatches.map((match) => <Match match={match} />) }
        { !isExpanded
          ? hiddenMatchesCount > 0 &&
            <div class="has-text-centered">
              <a onClick={this.toggleExpanded.bind(this, true)}>Show {hiddenMatchesCount} More Matches</a>
            </div>
          : <div class="has-text-centered">
              <a onClick={this.toggleExpanded.bind(this, false)}>Hide Extra Matches</a>
            </div>
        }
      </div>
    );
  }
};
