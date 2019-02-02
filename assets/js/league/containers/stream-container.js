import { connect } from 'preact-redux';
import { h, Component } from 'preact';

import { StreamDisplay } from '../components/stream-display';

const mapStateToProps = (state, ownProps) => {
  const channelData = state.twitchChannels[ownProps.channelName];
  return {
    loading: state.loadingChannelStatus && !channelData,
    channelData: channelData
  };
};


export const StreamContainer = connect(
  mapStateToProps
)(StreamDisplay);
