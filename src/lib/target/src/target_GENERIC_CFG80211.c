#include <stdio.h>
#include <stdbool.h>

#include "os_nif.h"
#include "util.h"
#include "log.h"
#include "target.h"


/* Prefix for the dummy serial number: "OSE" (OpenSync Extender) */
#define SERIAL_NO_PREFIX    "OSE"

bool target_serial_get(void *buff, size_t buffsz)
{
    size_t n;
    os_macaddr_t mac;

    memset(buff, 0, buffsz);

    /* Dummy serial number implementation: use eth0 MAC address with a prefix */
    if (os_nif_macaddr("eth0", &mac))
    {
        n = snprintf(buff, buffsz,
                     SERIAL_NO_PREFIX PRI(os_macaddr_plain_t),
                     FMT(os_macaddr_t, mac));
        if (n >= buffsz)
        {
            LOG(ERR, "Buffer not large enough");
            return false;
        }
        return true;
    }
    return false;
}

bool target_hw_revision_get(void *buff, size_t buffsz)
{
    snprintf(buff, buffsz, "%s", "Rev 1.0");
    return true;
}
