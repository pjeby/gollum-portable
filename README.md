# Instant Gollum - Just Add Docker

`gollum-portable` is a self-contained, ready-to-use Gollum wiki in a dockerized form.  If you have docker-compose or Docker Toolbox installed, all you need to do is:

```bash
$ git clone https://github.com/pjeby/gollum-portable my-wiki
$ cd my-wiki
$ ./docker/setup.sh
No docker-compose.yml found; initializing...
No gollum-settings.env found; creating...

--- Commit Log Settings ---
Your name [Anonymous]: Some Person
Your email [anon@anon.com]: some.person@my.address
Your timezone [UTC]: America/New_York

--- Wiki Settings ---
Gollum options [--h1-title --allow-uploads --live-preview]:

Settings saved to gollum-settings.env.  Use 'docker-compose up -d' to start, 
or edit docker-compose.yml to customize other settings first.

$ docker-compose up -d
```

And then open `localhost:4567` in your browser.  Congratulations!  You now have a wiki that should autostart when you turn on your machine (or start your docker VM, if you're on Mac or Windows).  You can re-run `./docker/setup.sh` at any time to edit the settings, though you'll need to restart the service afterward.

Your wiki repository is the directory you cloned into, and you can back it up, or move it to another machine and `docker-compose up -d` there.  (The two settings files, `docker-compose.yml` and `gollum-settings.env`, are not part of the repository, so if you copy it by cloning, you'll need to rerun the setup on the other machine.)

Once created, the two settings files can be copied into any gollum wiki directory and used to start a local dockerized wiki.  

Mac and Windows users, please note: due to the limitations of docker-machine, you have to perform the above steps in a directory under `/Users` or `C:\Users`, respectively, and you may need to use your Docker Machine's IP rather than `localhost` to access the wiki.
