import _ from 'lodash';
import { h, Component } from 'preact';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';

import { TWITCH_CHANNEL } from './constants';

import { LeagueContainer } from "./containers/league-container";
import { StreamContainer } from "./containers/stream-container";

import { RulesScreen } from './screens/rules-screen';

import { Navbar } from './components/navbar';


export class App extends Component {
  render() {
    return (
      <Tabs selectedTabClassName="is-active">
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

              <div class="columns is-centered">
                <div class="column is-narrow">
                  <StreamContainer channelName={TWITCH_CHANNEL} />
                </div>
              </div>
            </div>
          </div>

          <div class="hero-foot">
            <nav class="tabs is-centered is-boxed has-margin-top-md">
              <div class="container">
                <TabList>
                  <Tab>
                    <a>
                      <span class="icon is-small"><FontAwesomeIcon icon="trophy" /></span>
                      <span>Matches</span>
                    </a>
                  </Tab>
                  <Tab>
                    <a>
                      <span class="icon is-small"><FontAwesomeIcon icon="gavel" /></span>
                      <span>Rules</span>
                    </a>
                  </Tab>
                </TabList>
              </div>
            </nav>
          </div>
        </div>

        <main class="main">
          <section class="section">
            <div class="container">
              <TabPanel>
                <LeagueContainer />
              </TabPanel>
              <TabPanel>
                <RulesScreen />
              </TabPanel>
            </div>
          </section>
        </main>
      </Tabs>
    );
  }
}
