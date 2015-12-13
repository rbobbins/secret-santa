A script for generating Secret Santas. It randomly assigns each person to a secret santa. It is not deterministic, unless you only have 2 participants.

## Motivation
You want to organize a Secret Santa. You want to participate in the Secret Santa, but you don't want to know who's buying your gift. This script will randomly assign secret santas. It makes it more annoying to learn who your secret santa is, because you have to look in your "Sent" messages

## Usage
### Dry run
```
$ ruby main.rb -f guestlist.yml --dry-run
```
### Fo'real
```
$ ruby main.rb -f guestlist.yml -u mygmailusername
Enter your GMail password (typing will be hidden):
```

## Notes
- `guestlist.example.yml` is an example guestlist. Copy it to `guestlist.yml` to create your own guestlist.
- `email_template.example.txt` is an example email body. Copy it to `email_template.txt`. Feel free to customize (duh) your email body
- This is hardcoded to support sending emails from a gmail address, but you can change that in main.rb
- If you have 2 factor-auth setup for gmail, you'll need to create an application-specific password. See: http://stackoverflow.com/questions/25597507/netsmtpauthenticationerror
