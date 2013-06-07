# Luminosity Socket

Server-side code for running scientific and educational collaboration environments.

## Getting Started
    
    # Watch changes and restart server on change
    cake watch
    nodemon app.js

## Workflows

How would people interact with such a service?

### Science Service

  * Viewing scientific data collaborativally
  * What kind of data would be visualized?
  * Astronomers like FITS images.  Stretching and scaling FITS images collaboratively.
  * Table manipulations (applying functions to columns and visualizing results)
  * Annotation of FITS images.
  * How does DS9 promote collaborative efforts? Annotation files are pasted along? (ping Kevin S at ETH)
  * WorldWide Telescope over WebSockets.
  
  * Examining data
  * Planning observations
  * Annotating sky

### Educational Service


### Pilot/Passanger Mode

  * What are ways to control PP?
  * Pilot driving the collaboration.
  * Whomever starts the session is the default pilot
  * Passing control must be approved by current pilot
  * Passangers can request to be pilot
  * Passangers are free to control the interface, but their state does not propagate.
  * Passangers are free to sync with pilot at any time.
  * Pilots may request passangers to sync
  
  
  Suppose n users connect to a session.  The instigator is always pilot by default.
  
  * Implement interface to start a session. User presses start and is the default pilot.
  * URL is shared or session is marked on homepage with people able to join.
  
QUICK THOUGHT: Effort to promote transparency in science.  Show all running sessions.  Sessions maybe public or private.  All sessions have title and tags.

  * By default all passangers are listening to pilot.
  
TODO:

  * Figure out routes in `express`.
  * Generate URLS with a session id.
  

#### What are ways to promote collaboration?

People are more productive whenever watched by their piers.  Showing everyone's state will promote involvement in collaboration.  A passanger may be in three modes
  
  * Full passanger mode
  * Self-exploration (any other member can voluntarily sync with passanger without approval)
  * Private exploration (no other member may sync with passanger)

The UI will display the state of each member (Passanger/Self Pilot/Private).  Recording analytics on how these states are used will be interesting.  For instance will someone in private mode later share their application state? Are there scientists who consistently participate passively, remaining in private mode? Do people use it to prep a visualization before sharing?

### Predictive pilot/passanger mode

  * Easiest implementation of PP mode is to have explicit passangers
  * What about detecting user behavior?
