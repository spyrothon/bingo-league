import _ from 'lodash';
import { h, Component } from 'preact';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';

import { TWITCH_CHANNEL } from './constants';

import { LeagueContainer } from "./containers/league-container";
import { StreamContainer } from "./containers/stream-container";

import { RulesScreen } from './screens/rules-screen';
import { DetailsScreen } from './screens/details-screen';

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
              <h1 class="title header">Spyrothon Bingo League</h1>

              <p class="is-size-5">
                The Spyrothon Bingo League is a 2v2 Lockout Bingo League based on <em>Spyro 2: Ripto's Rage</em> with a $250 prize pool. The League will run from March until May 2019. All skill levels are welcome. Signups are open until Feburary 21st!
              </p>

              <div class="columns is-centered has-margin-top-lg">
                <div class="column is-narrow has-text-centered">
                  <a class="button is-white is-large has-header-shadow" href="https://goo.gl/forms/ukKffjDoHugEoXTd2" target="_blank" rel="nofollow noopener">Sign up Now</a>
                </div>
              </div>

              <div class="columns is-centered">
                <div class="column is-10-tablet is-8-desktop">
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
                      <span class="icon is-small"><FontAwesomeIcon icon="info-circle" /></span>
                      <span>Details</span>
                    </a>
                  </Tab>
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
                <DetailsScreen />
              </TabPanel>
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
