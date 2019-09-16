ifeq ($(VERBOSE),1)
EXPORT_FLAGS := -v
endif

BACKUP_DIRECTORY := quickbuild-backup
export RUBYLIB=lib/quickbuild-config/lib

all: pull export commit push

pull:
	(cd "${BACKUP_DIRECTORY}" && git checkout --force master && git reset --hard && git pull)

export:
	lib/quickbuild-config/bin/quickbuild-config --server ${SERVER} --output "${BACKUP_DIRECTORY}" --export '*' ${EXPORT_FLAGS}

commit:
	(cd "${BACKUP_DIRECTORY}" && git add --verbose . && git commit -m "Backup at $(date +%F %T)")

push:
	(cd "${BACKUP_DIRECTORY}" && git push origin master)
