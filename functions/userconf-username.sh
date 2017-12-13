import die
import rootuser
import userconf

read-userconf-username() {
    userconf-read username
    userconf-require-param UNIX_USERNAME
}
