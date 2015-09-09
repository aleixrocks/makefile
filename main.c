#include "cookies.h"

#ifdef CONFIG_TOPING
#include "toping.h"
#endif

#ifdef CONFIG_MIKL
#include "milk.h"
#endif

int main() {
	ask_for_cookies();

	#ifdef CONFIG_TOPING
	ask_for_toping();
	#endif

	#ifdef CONFIG_MILK
	ask_for_milk();
	#endif
}
